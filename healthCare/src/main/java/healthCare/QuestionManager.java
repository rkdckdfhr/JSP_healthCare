package healthCare;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QuestionManager {

    /// ServletContext 대신 순수 자바 static Map에 카테고리별 문항을 저장
    private static Map<String, List<String>> questionMap = new HashMap<>();

    /// 카테고리별 문항 리스트를 가져오는 메서드 (파라미터로 category만 받음)
    public static List<String> getQuestions(String category)
    {
        List<String> list = questionMap.get(category);

        // 해당 카테고리가 처음 호출되어 비어있다면 초기 문항 세팅
        if (list == null)
        {
            list = new ArrayList<>();
            if ("mental".equals(category)) {
                list.addAll(Arrays.asList(
                    "최근 2주 동안 우울하거나 슬픈 감정을 자주 느꼈나요?",
                    "평소 스트레스를 해소할 만한 취미나 여가 활동이 있나요?",
                    "일상생활에서 불안감이나 초조함을 느끼는 빈도는 어떠한가요?",
                    "자신의 삶과 현재 상황에 대한 전반적인 만족도는 어떠한가요?",
                    "주변 사람들과의 대인관계가 원만한가요?",
                    "최근 들어 집중력이 떨어지거나 기억력이 저하되었나요?",
                    "아침에 일어났을 때 하루를 시작하는 활력은 어떠한가요?",
                    "스스로 감정 기복을 조절하거나 화를 다스리는 데 어려움이 있나요?",
                    "어려운 일이 닥쳤을 때 긍정적으로 대처할 자신감이 있나요?",
                    "미래에 대한 걱정이 일상생활에 지장을 주나요?"
                ));
            } else if ("body".equals(category)) {
                list.addAll(Arrays.asList(
                    "현재 느끼는 전반적인 체력 상태는 어떠한가요?",
                    "평소 몸의 가벼움과 활력 정도는 어떠한가요?",
                    "규칙적인 운동(주 3회 이상) 실천 정도는 어떠한가요?",
                    "목, 어깨, 허리 등 관절이나 근육의 편안함 정도는 어떠한가요?",
                    "계단을 오르거나 가벼운 달리기 시 심폐 지구력 상태는 어떠한가요?",
                    "평소 면역력(잔병치레가 없는 정도) 상태는 어떠한가요?",
                    "충분한 휴식 후 신체 컨디션 회복력은 어떠한가요?",
                    "일상적인 활동을 할 때 느끼는 근력 상태는 어떠한가요?",
                    "평소 앉거나 걸을 때 올바른 자세를 유지하는 정도는 어떠한가요?",
                    "신체적인 건강이 현재 삶의 질에 미치는 긍정적 영향은 어떠한가요?"
                ));
            } else if ("eating".equals(category)) {
                list.addAll(Arrays.asList(
                    "하루 3끼 규칙적인 식사 패턴 유지 정도는 어떠한가요?",
                    "식사 시 신선한 채소와 과일 섭취량은 어떠한가요?",
                    "인스턴트, 패스트푸드 등 가공식품을 적게 먹는 정도는 어떠한가요?",
                    "하루 1.5리터 이상의 충분한 수분(물) 섭취량은 어떠한가요?",
                    "맵고 짠 자극적인 음식을 피하는 정도는 어떠한가요?",
                    "야식이나 불규칙한 간식을 자제하는 정도는 어떠한가요?",
                    "식사 시 천천히 꼭꼭 씹어 먹는 습관은 어떠한가요?",
                    "단당류(탄산음료, 과자 등) 섭취를 조절하는 정도는 어떠한가요?",
                    "자신의 활동량에 알맞은 적정 식사량 조절 정도는 어떠한가요?",
                    "평소 소화가 잘 되고 위장 건강이 편안한 정도는 어떠한가요?"
                ));
            } else if ("sleep".equals(category)) {
                list.addAll(Arrays.asList(
                    "하루 7~8시간의 적정 수면 시간 유지 정도는 어떠한가요?",
                    "잠자리에 누운 후 30분 이내에 잠드는 입면 능력은 어떠한가요?",
                    "수면 중 깨지 않고 푹 자는 숙면 정도는 어떠한가요?",
                    "아침에 일어났을 때 느끼는 개운함과 상쾌함은 어떠한가요?",
                    "매일 일정한 시간에 자고 일어나는 수면 규칙성은 어떠한가요?",
                    "낮 시간 동안 졸음이 쏟아지지 않는 맑은 각성 상태는 어떠한가요?",
                    "취침 전 스마트폰이나 TV 시청을 자제하는 정도는 어떠한가요?",
                    "코골이나 수면 무호흡 없이 편안하게 호흡하는 정도는 어떠한가요?",
                    "수면에 방해되지 않는 편안한 침실 환경(빛, 소음 등) 상태는 어떠한가요?",
                    "수면의 질이 다음 날 컨디션에 미치는 긍정적 영향은 어떠한가요?"
                ));
            } else if ("health".equals(category)) {
                /// 4개 카테고리에서 각각 랜덤하게 3문항씩 추출하여 총 12문항 초기화
                String[] categories = {"body", "mental", "eating", "sleep"};
                for (String cat : categories) {
                    /// 원본 리스트 순서가 섞이지 않도록 복사본 생성 후 셔플
                    List<String> copyList = new ArrayList<>(getQuestions(cat));
                    Collections.shuffle(copyList);
                    
                    /// 문항이 3개 미만일 경우를 대비해 안전하게 추출 개수 제한
                    int pickCount = Math.min(3, copyList.size());
                    for (int i = 0; i < pickCount; i++) {
                        list.add(copyList.get(i));
                    }
                }
            }
            
            questionMap.put(category, list);
        }
        return list;
    }

    /// 카테고리별 문항 추가
    public static void addQuestion(String category, String question) {
        /// 카테고리 별 리스트
        List<String> questions = getQuestions(category);
        /// 매개변수로 받은 문항 추가
        if (question != null && !question.trim().isEmpty()) {
            questions.add(question.trim());
        }
    }

    /// 카테고리별 문항 삭제
    public static void removeQuestion(String category, int index) {
        /// 카테고리 별 리스트
        List<String> questions = getQuestions(category);

        /// 받아온 인덱스 값의 문항 삭제
        if (index >= 0 && index < questions.size()) {
            questions.remove(index);
        }
    }
}