/*
주어진 두개의 테이블 (session_timestamp, user_session_channel)을 바탕으로
월별마다 액티브한 사용자들의 수를 카운트한다 (MAU - Monthly Active User)
○ 여기서 중요한 점은 세션의 수를 세는 것이 아니라 사용자의 수를 카운트한다는
점이다.
○ 결과는 예를 들면 아래와 같은 식이 되어야 한다:
■ 2019-05: 400
■ 2019-06: 500
■ 2019-07: 600
*/

SELECT to_char(st.ts, 'YYYY-MM') date, COUNT(DISTINCT usc.userID) user_cnt
FROM raw_data.session_timestamp st
JOIN raw_data.user_session_channel usc USING (sessionID)
GROUP BY 1
ORDER BY 1;
