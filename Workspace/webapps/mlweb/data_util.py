import numpy as np
import pandas as pd
import os
import pickle
import joblib
import base64
import io
import re
import cv2
import csv
from PIL import Image
from keras.models import load_model as load_keras_model
from sklearn.preprocessing import OneHotEncoder
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense, Dropout, Input
from tensorflow.keras.optimizers import Adam

BASE_DIR = os.path.join(os.path.dirname(__file__), 'static')

def load_model(model_name):
    exts = ['pickle', 'joblib', 'h5', 'keras']
    for ext in exts:
        model_path = os.path.join(BASE_DIR, 'models', f"{model_name}.{ext}")
        if os.path.exists(model_path):
            try:
                if ext == 'pickle':
                    with open(model_path, 'rb') as f: return pickle.load(f)
                elif ext == 'joblib': return joblib.load(model_path)
                else: return load_keras_model(model_path)
            except Exception as e:
                raise RuntimeError(f"Failed to load {model_path}: {e}")
    raise FileNotFoundError(f"Model '{model_name}' not found in {BASE_DIR}")

def encode_image(image):
    image.stream.seek(0)
    gray = Image.open(image.stream).convert("L").resize((64, 64))
    gray_arr = np.expand_dims(np.expand_dims(np.array(gray)/255.0, -1), 0)

    image.stream.seek(0)
    rgb = Image.open(image.stream).convert("RGB")
    buf = io.BytesIO()
    rgb.save(buf, format="JPEG")
    encoded = base64.b64encode(buf.getvalue()).decode("utf-8")
    return gray_arr, encoded

def preprocess_base64_image(img_base64):
    img_str = re.sub('^data:image/.+;base64,', '', img_base64)
    img = cv2.imdecode(np.frombuffer(base64.b64decode(img_str), np.uint8), cv2.IMREAD_GRAYSCALE)
    img = cv2.bitwise_not(img)
    img = cv2.resize(img, (8, 8), interpolation=cv2.INTER_AREA)
    return ((img / 255.0) * 16).flatten().reshape(1, -1)

def save_csv(file_name, data, header):
    path = os.path.join(BASE_DIR, 'data', f"{file_name}.csv")
    file_exists = os.path.exists(path)

    clean_data = [int(x) if isinstance(x, (np.integer,)) 
                  else float(x) if isinstance(x, (np.floating,)) 
                  else x for x in data]

    with open(path, "a", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        if not file_exists:
            writer.writerow(header)
        writer.writerow(clean_data)

# ---------------- RPS 시퀀스 준비 ----------------
def prepare_rps_sequence(user_name, seq_len=10, recent_games=100, for_predict=False):
    """유저별 CSV 데이터를 읽어 LSTM 입력 시퀀스로 변환"""
    path = os.path.join(BASE_DIR, "data", f"rps_data_{user_name}.csv")
    if not os.path.exists(path):
        dummy = np.zeros((1, seq_len, 3))
        return (dummy, None) if for_predict else (dummy, np.zeros((1,)))

    df = pd.read_csv(path).tail(recent_games if not for_predict else seq_len+1)
    if df.empty or 'player_move' not in df.columns:
        dummy = np.zeros((1, seq_len, 3))
        return (dummy, None) if for_predict else (dummy, np.zeros((1,)))

    # 가위(0), 바위(1), 보(2) 원핫 인코딩
    encoder = OneHotEncoder(categories=[[0,1,2]], sparse_output=False, handle_unknown='ignore')
    moves = encoder.fit_transform(df[['player_move']])

    # 예측 모드 (최근 seq_len 라운드만 사용)
    if for_predict:
        if len(moves) < seq_len:
            pad = np.zeros((seq_len - len(moves), 3))
            moves = np.vstack([pad, moves])
        return moves[-seq_len:].reshape(1, seq_len, 3), None

    # 학습 모드 (전체 시퀀스 + 타겟 생성)
    if len(moves) <= seq_len:
        dummy = np.zeros((1, seq_len, 3))
        return dummy, np.zeros((1,))

    X, y = [], []
    for i in range(len(moves) - seq_len):
        X.append(moves[i:i+seq_len])
        y.append(df['player_move'].iloc[i+seq_len])
    return np.array(X), np.array(y)

# ---------------- AI 예측 ----------------
def predict_player_move(user_name):
    """플레이어의 다음 행동(0=가위,1=바위,2=보) 예측"""
    base_model_path = os.path.join(BASE_DIR, "models", "rps_ai_base.keras")
    user_model_path = os.path.join(BASE_DIR, "models", f"rps_ai_{user_name}.keras")

    seq_len = 10

    # 유저 모델이 있으면 사용, 없으면 베이스 모델 사용
    model_path = user_model_path if os.path.exists(user_model_path) else base_model_path
    model = load_keras_model(model_path)

    X, _ = prepare_rps_sequence(user_name, seq_len, for_predict=True)
    probs = model.predict(X, verbose=0)[0]

    # 확률이 가장 높은 행동 반환 (랜덤 선택 제거)
    return int(np.argmax(probs))

# ---------------- 파인튜닝 ----------------
def finetune_rps_model(user_name):
    """유저 데이터를 이용해 개별 모델을 베이스 모델로부터 파인튜닝"""
    base_model_path = os.path.join(BASE_DIR, "models", "rps_ai_base.keras")
    user_model_path = os.path.join(BASE_DIR, "models", f"rps_ai_{user_name}.keras")

    seq_len = 10
    recent_games=100

    from tensorflow.keras.models import clone_model
    base_model = load_keras_model(base_model_path)

    X, y = prepare_rps_sequence(user_name, seq_len, recent_games, for_predict=False)
    if len(y) < 10:
        print(f"Fine-tuning 스킵 (데이터 부족: {len(y)})")
        return None

    # 베이스 모델 복제 후 유저 데이터로 학습
    model = clone_model(base_model)
    model.set_weights(base_model.get_weights())
    model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
    model.fit(X, y, epochs=5, batch_size=min(16, len(X)), verbose=0)

    model.save(user_model_path)
    print(f"유저 모델 저장 완료: {user_model_path}")
    return model