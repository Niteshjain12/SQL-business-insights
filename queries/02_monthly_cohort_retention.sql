with customer_cohorts as (

    select
        customer_id,
        date_trunc('month', created_at) as cohort_month
    from ecom.customers

),

customer_orders as (

    select distinct
        customer_id,
        date_trunc('month', created_at) as order_month
    from ecom.orders
    where lower(status) <> 'cancelled'

),

latest_month as (

    select
        max(date_trunc('month', created_at)) as latest_order_month
    from ecom.orders

),

customer_activity as (

    select
        c.customer_id,
        c.cohort_month,

        (
            extract(year from age(o.order_month, c.cohort_month)) * 12
            +
            extract(month from age(o.order_month, c.cohort_month))
        ) as month_offset

    from customer_cohorts c

    left join customer_orders o
        on c.customer_id = o.customer_id

),

cohort_summary as (

    select

        cohort_month,

        count(distinct customer_id) as cohort_size,

        count(distinct case when month_offset = 1 then customer_id end) as m1_retained,

        count(distinct case when month_offset = 2 then customer_id end) as m2_retained,

        count(distinct case when month_offset = 3 then customer_id end) as m3_retained

    from customer_activity

    group by cohort_month

)

select

    c.cohort_month,

    c.cohort_size,

    case
        when c.cohort_month + interval '1 month' <= l.latest_order_month
        then c.m1_retained
        else null
    end as m1_retained,

    case
        when c.cohort_month + interval '2 month' <= l.latest_order_month
        then c.m2_retained
        else null
    end as m2_retained,

    case
        when c.cohort_month + interval '3 month' <= l.latest_order_month
        then c.m3_retained
        else null
    end as m3_retained,

    case
        when c.cohort_month + interval '1 month' <= l.latest_order_month
        then round(c.m1_retained * 1.0 / nullif(c.cohort_size,0),4)
        else null
    end as m1_retention_rate,

    case
        when c.cohort_month + interval '2 month' <= l.latest_order_month
        then round(c.m2_retained * 1.0 / nullif(c.cohort_size,0),4)
        else null
    end as m2_retention_rate,

    case
        when c.cohort_month + interval '3 month' <= l.latest_order_month
        then round(c.m3_retained * 1.0 / nullif(c.cohort_size,0),4)
        else null
    end as m3_retention_rate

from cohort_summary c
cross join latest_month l

order by c.cohort_month;
