from flask import Blueprint
from flask import render_template, request, redirect, url_for, jsonify

from ..data_util import *

models_bp = Blueprint("models", __name__, url_prefix="/models")

@models_bp.route("/iris", methods=["GET", "POST"])
def iris():
    predicted_species = None
    if request.method == "POST":

        petal_width = request.form.get('petal_width', '0')
        petal_length = request.form.get('petal_length', '0')
        sepal_width = request.form.get('sepal_width', '0')
        sepal_length = request.form.get('sepal_length', '0')

        iris_model = load_model('iris_model')
        try:
            input_data = [[float(sepal_length),float(sepal_width),float(petal_length),float(petal_width)]]
            predicted_species = iris_model.predict(input_data)
        except:
            print(iris_model)
        print("예측된 품종 : ", predicted_species) 

    return render_template('iris.html', result = predicted_species)

@models_bp.route("/cat_dog", methods=["GET", "POST"])
def cat_dog():
    pred_result = None
    encoded_img = None

    if request.method == "POST":
        image = request.files["image"]
        if image:
            cat_dog_model = load_model("cat_dog_cnn_model")
            gray_img, encoded_img = encode_image(image)
            pred = cat_dog_model.predict(gray_img)[0]
            pred_result = "cat" if pred[0] > pred[1] else "dog"

            # 디버그 
            print(pred)

    return render_template('cat_dog.html', result = pred_result, image_data = encoded_img)

@models_bp.route('/number', methods=['GET', 'POST'])
def number():
    if request.method == 'POST':
        # POST: Canvas 이미지 받아서 예측 수행
        data = request.json
        img_base64 = data['image']

        img_vector = preprocess_base64_image(img_base64)
        num_model = load_model("number_model")

        pred = num_model.predict(img_vector)[0]
        proba = num_model.predict_proba(img_vector).tolist()[0]

        return jsonify({'prediction': int(pred), 'probabilities': proba})
    
    # GET: 페이지 렌더링
    return render_template('number.html')



player_money = 10000
opponent_money = 10000
wins, loses, draws = 0, 0, 0
game_logs = []

@models_bp.route("/rps", methods=["GET", "POST"])
def rps():
    global player_money, opponent_money, wins, loses, draws, game_logs
    result_text = None
    user_name = "kgm423423"  # 세션/로그인 시스템이 있다면 거기서 가져올 수 있음

    # 수동 보유금 조정
    if "set_money" in request.form:
        try:
            input_player_money = int(request.form.get("set_player_money", player_money))
            input_opponent_money = int(request.form.get("set_opponent_money", opponent_money))
            player_money, opponent_money = input_player_money, input_opponent_money
            result_text = f"보유금 수동 설정: 플레이어 {player_money}, 상대 {opponent_money}"
            game_logs.clear()
        except ValueError:
            result_text = "보유금 입력 오류"

    # 게임 진행
    elif "player_move" in request.form:
        bet_amount = int(request.form.get("bet_amount", 0))
        
        # 배팅액 검증
        if bet_amount < 500:
            return render_template("rps.html", player_money=player_money,
                                   opponent_money=opponent_money, result_text="배팅액은 500 이상이어야 합니다.")
        if bet_amount > player_money or bet_amount > opponent_money:
            return render_template("rps.html", player_money=player_money,
                                   opponent_money=opponent_money, result_text="배팅액이 보유금보다 많습니다.")

        # 가위바위보 결과
        predicted_player = predict_player_move(user_name)
        opponent_move = (predicted_player + 1) % 3
        player_move = int(request.form.get("player_move"))
        result = 0 if player_move == opponent_move else (1 if (player_move - opponent_move) % 3 == 1 else -1)


        # 승패 집계
        if result == 1:
            player_money += bet_amount
            opponent_money -= bet_amount
            wins += 1
        elif result == -1:
            player_money -= bet_amount
            opponent_money += bet_amount
            loses += 1
        else:
            draws += 1

        # 유저별 CSV에 로그 저장
        csv_name = f"rps_data_{user_name}"
        header = ['player_money', 'opponent_money', 'bet_amount', 'player_move', 'opponent_move', 'result']
        log_data = [player_money, opponent_money, bet_amount, player_move, opponent_move, result]
        save_csv(csv_name, log_data, header)

        total_games = wins + loses + draws
        # 10판마다 Fine-Tuning
        if total_games % 10 == 0:
            finetune_rps_model(user_name)

        # 결과 문자열
        move_map = {0: "가위", 1: "바위", 2: "보"}
        result_map = {0: "DRAW", 1: "WIN", -1: "LOSE"}
        
        win_rate = (wins / (total_games-draws) * 100) if (total_games-draws) > 0 else 0
        result_text = (f"결과: {result_map[result]} (상대: {move_map[opponent_move]}) | "
                       f"현재 승률: {win_rate:.1f}% ({total_games}판 중 {wins}승)")

        #디버깅용
        print(f"예상한 수 : {move_map[predicted_player]} | 실제 수 : {move_map[player_move]}")

        # 로그 리스트에 추가 (화면 표시용)
        game_logs.append([bet_amount, move_map[player_move], move_map[opponent_move], result])

    return render_template("rps.html",
                           player_money=player_money,
                           opponent_money=opponent_money,
                           result_text=result_text,
                           logs=game_logs)