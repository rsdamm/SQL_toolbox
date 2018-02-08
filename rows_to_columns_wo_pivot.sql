--for sample out see rows_to_columns_wo_pivot.txt
select a.tag_type,
    sum(a.inapplicableCt) as inapplicablect,
    sum(a.damagedCt)        as damagedCt,
    sum(a.fraudCt)   as fraudCt,
    sum(a.unapprovedCt)   as unapprovedCt,
    sum(a.pendingCt)   as pendingCt 
from (select tag_type,
  case when tag_status='inapplicable' then 1 else 0 end as inapplicableCt,
  case when tag_status='damaged' then ct else 0 end as damagedCt,
  case when tag_status='fraud' then ct else 0 end as fraudCt,
  case when tag_status='unapproved' then ct else 0 end as unapprovedCt,  
  case when tag_status='pending'    then ct else 0 end as pendingCt 
  from log_stats
  where  web_request_type='storefront') a
group by a.tag_type;  
