<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/serviceCenter.css" />
<title>Question</title>

</head>
<body onselectstart="return false" ondragstart="return false">
<jsp:include page="../headerFooter/header.jsp" flush="false"></jsp:include>

    <header>

    </header>
    <div id="contentJoinSelect" class="container">
        <div class="JoinSelect" style="background: #fff;color:#10a3e6;" id="question">
            자주하는 질문
        </div>
        <div class="JoinSelect" id="dissatisfaction">
            불만 사항 접수
        </div>
        <script type="text/javascript">

        	$('#dissatisfaction').click(function(){
        		location.href = "/board/list";
            });	

        
        </script>
    </div>
    <div style="width: 1200px;margin: 30px auto;height: auto;" id="frequentQuestion">
       <div style="width: 900px; margin: 0 auto">
        <div class="questionAnswer">
                <div class="question"> <!-- question : 질문 구간 -->
                    미안해
                </div>
                <div class="questionimg open"> <!-- question 아래 설명이 있다는 이미지-->
                    
                </div>
                <div class="answer"> <!-- answer : 답변 구간-->
                    내가 많이
                </div>
        </div>
        <div class="questionAnswer">
                <div class="question"> <!-- question : 질문 구간 -->
                    행복하자
                </div>
                <div class="questionimg open"> <!-- question 아래 설명이 있다는 이미지-->
                    
                </div>
                <div class="answer"> <!-- answer : 답변 구간-->
                    저도 잘 모르겠어요 고객님
                </div>
        </div>
        <div class="questionAnswer">
                <div class="question"> <!-- question : 질문 구간 -->
                    결제가 되었는데 작동이 안되요
                </div>
                <div class="questionimg open"> <!-- question 아래 설명이 있다는 이미지-->
                    
                </div>
                <div class="answer"> <!-- answer : 답변 구간-->
                    저도 잘 모르겠어요 고객님
                </div>
        </div>
        <div class="questionAnswer">
                <div class="question"> <!-- question : 질문 구간 -->
                    결제가 되었는데 작동이 안되요
                </div>
                <div class="questionimg open"> <!-- question 아래 설명이 있다는 이미지-->
                    
                </div>
                <div class="answer"> <!-- answer : 답변 구간-->
                    저도 잘 모르겠어요 고객님
                </div>
        </div>
        <div class="questionAnswer">
                <div class="question"> <!-- question : 질문 구간 -->
                    우리 집을 못찾겠군요
                </div>
                <div class="questionimg open"> <!-- question 아래 설명이 있다는 이미지-->
                    
                </div>
                <div class="answer"> <!-- answer : 답변 구간-->
                    착해 빠진 게 독한 소리 할 때<br />
분명 지 속도 속 아니었겠죠<br />
잡는 목소리 머뭇거리지도 않고<br />
날 떠날 땐 분명 이 악물었겠죠<br />
상처받지 않은 듯 돌아섰지만<br />
애같이 눈물을 사탕처럼<br />
막 흘리면서 가<br />
다 흘리면서 가<br />
자기보다 큰 슬픔을<br />
쇠똥구리처럼 힘겹게<br />
굴리면서 가<br />
난 왜 그런 널 안지 못했을까<br />
그날 결판 짓던 순간에<br />
터널 같던 너의 눈가<br />
그 생각만 하면 자꾸 내 맘이 짠해<br />
저기요 좀 찾아주세요<br />
그 사람 나 아니면 갈 곳이 없어요<br />
마른 두 다리로 어딘가 헤맬 텐데<br />
내가 집이 돼주기로 했는데<br />
그리워서 그리워서<br />
밤하늘 바라봐요<br />
그대 알아<br />
나도 그대 마음과 같아<br />
시간 지나 사랑이면<br />
그래도 사랑이면<br />
Lonely you<br />
돌아와 너의 집으로<br />
서로의 심술 맞은 자존심<br />
딱 그 정도 거리만큼<br />
우린 떨어져 걸었어<br />
뾰족한 맘<br />
괜히 툭 뱉은 말들에 비해<br />
진심은 항상 한 박자 느렸어<br />
그 한 발짝 물러서기가<br />
그렇게 힘들어<br />
이 꼴 저 꼴 다 본 끝에<br />
여기까지네<br />
30평 아파트가 돼주고<br />
싶었는데<br />
겨우 원룸밖에 못 돼 줘서<br />
미안해<br />
처음엔 시원했어 너 떠나간 후<br />
싹 지워냈어 그런 줄 알았어<br />
근데 아니더라고 나도 모르게<br />
익숙한 뒷모습을 몰래<br />
따라가더라<br />
넌 줄 알았어<br />
친구들은 다 나쁜 년이라고<br />
술자리서 욕하는데<br />
속으론 지들이 뭘 안다고<br />
니 편들게 되더라<br />
머리가 아프네<br />
집 가야지 지갑 어디다 뒀더라<br />
그리워서 그리워서<br />
밤하늘 바라봐요<br />
그대 알아<br />
나도 그대 마음과 같아<br />
시간 지나 사랑이면<br />
그래도 사랑이면<br />
Lonely you<br />
돌아와 너의 집으로<br />
아저씨 사실 나 갈 곳 없어요<br />
그 사람 아니면<br />
내 마음 둘 곳 없어요<br />
어딜 가야 다시 볼 수 있을까요<br />
우리 집을 못 찾겠군요<br />
아저씨 그 사람 찾아주세요<br />
그 사람 나 아님 잠들 곳 없어요<br />
어딜 가야 다시 볼 수 있을까요<br />
우리 집을 못 찾겠군요<br />
그리워서 그리워서<br />
밤하늘 바라봐요<br />
그대 알아<br />
나도 그대 마음과 같아<br />
시간 지나 사랑이면<br />
그래도 사랑이면<br />
Lonely you<br />
돌아와 너의 집으로<br />
저 골목길 돌면 자주 걷던 길과<br />
너가 마중 나왔던 버스 정류장<br />
미용실을 지나<br />
오르막길 올라서<br />
가다 보면 어느새<br />
불 꺼진 너의 집 앞<br />
난 믿어<br />
그리워하다<br />
언젠가 우연처럼 만나게 될<br />
만화 같은 기적<br />
그 사람 지금 어디 있을까요<br />
우리 집을 못 찾겠군요<br />
돌아봐도 사랑이면<br />
그래도 사랑이면<br />
그땐 울고 있는<br />
나를 찾아줄래<br />

                </div>
        </div>
        <div class="questionAnswer"></div>
        <div class="questionAnswer"></div>
        <div class="questionAnswer"></div>
        </div>
    </div>
    <div style="width: 1200px;margin: 0 auto;height: 600px;display: none;" id="complaint">
       <div style="width: 900px; margin: 0 auto">
        <table class="complaintTable">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>아이디</th>
                <th>날짜</th>
            </tr>
            <a href="#">
                <tr>
                    <td>8</td>
                    <td>asdfsdf</td>
                    <td>mist_moss</td>
                    <td>18-07-18</td>
                </tr>
            </a>
            <a href="#">
                <tr>
                    <td>7</td>
                    <td>이상있는 장비가 있는데 어디다 연락하나요?</td>
                    <td>mist_moss</td>
                    <td>18-07-18</td>
                </tr>
            </a>
            <a href="#">
                <tr>
                    <td>6</td>
                    <td>아이디를 잊어버렸어요.</td>
                    <td>mist_moss</td>
                    <td>18-07-18</td>
                </tr>
            </a>
            <a href="#">
                <tr>
                    <td>5</td>
                    <td>예약이 안되요.</td>
                    <td>mist_moss</td>
                    <td>18-07-18</td>
                </tr>
            </a>
            <a href="#">
                <tr>
                    <td>4</td>
                    <td>결제가 되었는데 킥보드가 작동이 안되요.</td>
                    <td>mist_moss</td>
                    <td>18-07-18</td>
                </tr>
            </a>
            <a href="#">
                <tr>
                    <td>3</td>
                    <td></td>
                    <td>mist_moss</td>
                    <td>18-07-18</td>
                </tr>
            </a>
            <a href="#">
                <tr>
                    <td>2</td>
                    <td></td>
                    <td>mist_moss</td>
                    <td>18-07-18</td>
                </tr>
            </a>
            <a href="#">
                <tr>
                    <td>1</td>
                    <td></td>
                    <td>mist_moss</td>
                    <td>18-07-18</td>
                </tr>
            </a>
        </table>
        <div id="nextBottomPageControl">
           <div id="nextPageLayer">
            <span><a href="#"><img src="/img/prev.png"></a></span>
            <span><a href="#"><div>1</div></a></span>
            <span><a href="#"><div>2</div></a></span>
            <span><a href="#"><div>3</div></a></span>
            <span><a href="#"><div>4</div></a></span>
            <span><a href="#"><div>5</div></a></span>
            <span><a href="#"><div>6</div></a></span>
            <span><a href="#"><div>7</div></a></span>
            <span><a href="#"><div>8</div></a></span>
            <span><a href="#"><div>9</div></a></span>
            <span><a href="#"><div>10</div></a></span>
            <span><a href="#"><img src="/img/next.png"></a></span>
            </div>
            <div id="customerCenterSearch">
                <select>
                    <option>제목</option>
                    <option>아이디</option>
                </select>
                <input type="text" onkeypress="press(this.form)">
                <button onclick="submitForm()"></button>
            </div>
        </div>
        </div>
    </div>
<jsp:include page="../headerFooter/footer.jsp" flush="false"></jsp:include>
<script type="text/javascript" src="/js/serviceCenter.js"></script>
</body>
</html>