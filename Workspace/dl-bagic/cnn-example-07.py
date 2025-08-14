# webcam_yolo.py
from ultralytics import YOLO
import cv2

def main():
    # YOLOv8 모델 로드 (nano: 빠르고 가벼움)
    model = YOLO("yolov8s.pt")  # 처음 실행 시 자동 다운로드

    # 웹캠 열기 (0 = 기본 카메라)
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        raise RuntimeError("웹캠을 열 수 없습니다.")

    print("웹캠이 시작되었습니다. ESC 키를 누르면 종료됩니다.")

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        # YOLOv8 추론 (stream=True로 프레임별 결과 처리)
        results = model(frame, stream=True)

        # 탐지 결과를 영상 위에 그리기
        for r in results:
            annotated_frame = r.plot()  # 바운딩 박스가 그려진 프레임
            cv2.imshow("YOLOv8 Real-time Detection", annotated_frame)

        # ESC(27) 키로 종료
        if cv2.waitKey(1) & 0xFF == 27:
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    main()
