-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

SELECT cf_id, outcome, backers_count
FROM campaign
WHERE outcome = 'live'
GROUP BY cf_id
ORDER BY backers_count DESC
; 


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT cf_id, COUNT(DISTINCT backer_id) as count_backers
FROM backers
GROUP BY cf_id
ORDER BY count_backers DESC
;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT contacts.first_name, contacts.last_name, contacts.email, (campaign.goal - campaign.pledged) AS amount_remaining
INTO email_contacts_remaining_goal_amount
FROM contacts
LEFT JOIN campaign
ON (contacts.contact_id = campaign.contact_id)
WHERE campaign.outcome = 'live'
ORDER BY amount_remaining DESC
;



-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT bk.email, bk.first_name, bk.last_name, bk.cf_id, cp.company_name, cp.description, cp.end_date, (cp.goal - cp.pledged) AS left_of_goal
INTO email_backers_remaining_goal_amount
FROM backers as bk
LEFT JOIN campaign as cp
ON (bk.cf_id = cp.cf_id)
WHERE cp.outcome = 'live'
ORDER BY bk.last_name 
;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount

