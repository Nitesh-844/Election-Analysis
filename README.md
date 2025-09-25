# Election-Analysis
In this project I uses most relevant postgrea sql queries 
#Query Explaination:
1. Common Table Expression (CTE) RankedCandidates
•	WITH RankedCandidates AS: This section creates a Common Table Expression (CTE) named RankedCandidates, which is used to rank candidates based on their total votes within each constituency.
•	SELECT ... FROM constituencywise_details cd: This part of the CTE retrieves data from the constituencywise_details table, including:
o	cd.Constituency_ID: The ID of the constituency.
o	cd.Candidate: The name of the candidate.
o	cd.Party: The party of the candidate.
o	cd.EVM_Votes: The number of EVM votes received by the candidate.
o	cd.Postal_Votes: The number of postal votes received by the candidate.
o	cd.EVM_Votes + cd.Postal_Votes AS Total_Votes: The total votes received by the candidate (sum of EVM and postal votes).
•	ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank:
o	ROW_NUMBER() is a window function that assigns a unique rank to each candidate within their respective constituency.
o	PARTITION BY cd.Constituency_ID ensures that the ranking is done separately for each constituency.
o	ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC orders candidates by their total votes in descending order, so the candidate with the most votes gets rank 1.
•	JOIN ... ON ...: Joins are performed to combine information from related tables:
o	constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
o	statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
o	states s ON sr.State_ID = s.State_ID
•	WHERE s.State = 'Maharashtra': Filters the results to include only data related to the state of Maharashtra.
2. Main Query
•	SELECT ... FROM RankedCandidates rc: The main query retrieves data from the RankedCandidates CTE to find the winning and runner-up candidates for each constituency.
•	MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate:
o	CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END selects the candidate with the highest vote rank (rank 1) for each constituency.
o	MAX(...) ensures that only one candidate is selected for each constituency.
•	MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate:
o	CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END selects the candidate with the second highest vote rank (rank 2) for each constituency.
o	MAX(...) ensures that only one candidate is selected for each constituency.
•	JOIN ... ON ...: Joins the RankedCandidates CTE with the constituencywise_results table to get the constituency names.
•	GROUP BY cr.Constituency_Name: Groups the results by constituency name to ensure that the winning and runner-up candidates are determined for each constituency.
•	ORDER BY cr.Constituency_Name: Orders the results alphabetically by constituency name for easier readability.
