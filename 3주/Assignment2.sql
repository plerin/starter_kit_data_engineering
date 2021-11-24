/*
## Assignment2

- 사용자별로 처음과 마지막 채널 알아내기(ROW_NUMBER() 사용)

*/


SELECT t1.userid, t1.channel first_channel, t2.channel last_channel
FROM
(
  SELECT userid, channel
  FROM (
    SELECT ROW_NUMBER() OVER (PARTITION BY userid ORDER BY ts) ROW_NUM, userid, channel
    FROM raw_data.session_timestamp st
    JOIN raw_data.user_session_channel usc USING (sessionid)
  )
  WHERE ROW_NUM = 1
) t1
JOIN 
(
  SELECT userid, channel
  FROM (
    SELECT ROW_NUMBER() OVER (PARTITION BY userid ORDER BY ts DESC) ROW_NUM, userid, channel
    FROM raw_data.session_timestamp st
    JOIN raw_data.user_session_channel usc USING (sessionid)
  )
  WHERE ROW_NUM = 1
) t2 ON t1.userid = t2.userid
ORDER BY 1