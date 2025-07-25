SELECT
    H.hacker_id,
    H.name
FROM
    Hackers H
JOIN
    (SELECT
        S.hacker_id,
        COUNT(DISTINCT S.challenge_id) AS full_score_challenges
    FROM
        Submissions S
    JOIN
        Challenges C ON S.challenge_id = C.challenge_id
    JOIN
        Difficulty D ON C.difficulty_level = D.difficulty_level -- Join with Difficulty table
    WHERE
        S.score = D.score -- Condition for a full score, using score from Difficulty table
    GROUP BY
        S.hacker_id
    HAVING
        COUNT(DISTINCT S.challenge_id) > 1 -- Hackers with more than one full score
    ) FullScoreHackers ON H.hacker_id = FullScoreHackers.hacker_id
ORDER BY
    FullScoreHackers.full_score_challenges DESC,
    H.hacker_id ASC;
