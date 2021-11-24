/*
## Assignment 3

Gross_Revenue가 가장 큰 UserID 10개 찾기(refund 포함)
- 사용 테이블
  - user_session_channel & session_transcation
*/


SELECT t1.userid, SUM(t2.amount) Gross_Revenue
FROM raw_data.user_session_channel t1
JOIN raw_data.session_transaction t2 USING (sessionid)
WHERE t2.refunded IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;