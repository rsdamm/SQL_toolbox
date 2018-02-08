--sample input records in rows.png
--for sample output see report.png
--The SQL is useful for converting rows of data into columns.  It works when there is a known set of values that are 
--changed during a product release.  It can be used to 'pivot' data when the RDBMS does not have pivot built-in.  The example
--uses a SUM function, but it can also use a MAX or MIN with values other than 0 or 1 like Y or N. Original idea from asktom.
select a.tag_type,
    sum(a.inapplicableCt) as inapplicablect,
    sum(a.damagedCt)      as damagedCt,
    sum(a.fraudCt)        as fraudCt,
    sum(a.unapprovedCt)   as unapprovedCt,
    sum(a.pendingCt)      as pendingCt 
from (select tag_type,
  case when tag_status='inapplicable' then 1 else 0 end as inapplicableCt,
  case when tag_status='damaged' then ct else 0 end as damagedCt,
  case when tag_status='fraud' then ct else 0 end as fraudCt,
  case when tag_status='unapproved' then ct else 0 end as unapprovedCt,  
  case when tag_status='pending'    then ct else 0 end as pendingCt 
  from log_stats
  where  web_request_type='storefront') a
group by a.tag_type;  
