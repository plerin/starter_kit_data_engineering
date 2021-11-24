/*
## Assignment 4

채널별 월 매출액 테이블 만들기(본인 스키마 밑에 CTAS로 테이블 만들기)
- 사용 테이블 : session_timestamp & user_session_channel & session_transaction
- 필드 구성
  - year-month
  - channel
  - uniqueUsers(총 방문 사용자)
  - paidUsers(구매 사용자: refund한 경우도 판매 고려)
  - conversionRate(구매 사용자 / 총 방문 사용자)
  - grossRevenue(refund 포함)
  - netRevenue(refund 제외)
*/


CREATE TABLE plerin152.monthly_active_user_summary AS
SELECT 
  TO_CHAR(t1.ts, 'YYYY-MM') "year-month", 
  t2.channel, 
  COUNT(DISTINCT t2.userid) uniqueUsers,
  COUNT(DISTINCT CASE WHEN t3.refunded IS NOT NULL AND t3.amount <> 0 THEN t2.userid ELSE NULL END) paidUsers,
  ROUND((paidUsers::float / uniqueUsers::float)*100,2) conversionRate,
  SUM(COALESCE(t3.amount,0)) grossRevenue,
  SUM(CASE WHEN t3.refunded IS FALSE THEN t3.amount ELSE 0 END) netRevenue
FROM (
  raw_data.session_timestamp t1
  JOIN raw_data.user_session_channel t2 ON t1.sessionid = t2.sessionid
  LEFT JOIN raw_data.session_transaction t3 ON t1.sessionid = t3.sessionid
) 
GROUP BY 1, 2
ORDER BY 2, 1