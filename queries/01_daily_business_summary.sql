-- Query 01: Daily Business Summary
-- CEO Question: How are we doing today vs yesterday, and vs the same day last week?

with daily_orders as (

    select
        date(created_at) as order_date,
        count(*) as orders,
        sum(total) as revenue,
        avg(total) as aov,

        sum(
            case
                when payment_status = 'paid' then 1
                else 0
            end
        ) * 1.0 / nullif(count(*), 0) as paid_order_rate,

        sum(
            case
                when lower(status) = 'cancelled' then 1
                else 0
            end
        ) * 1.0 / nullif(count(*), 0) as cancelled_order_rate

    from ecom.orders

    group by date(created_at)

),

daily_refunds as (

    select
        date(created_at) as refund_date,
        sum(amount) as refunds_amount

    from ecom.refunds

    group by date(created_at)

)

select

    o.order_date,

    round(o.revenue, 2) as revenue,

    o.orders,

    round(o.aov, 2) as aov,

    round(o.paid_order_rate, 4) as paid_order_rate,

    round(o.cancelled_order_rate, 4) as cancelled_order_rate,

    round(coalesce(r.refunds_amount, 0), 2) as refunds_amount,

    round(
        (
            o.revenue
            - lag(o.revenue, 1) over (order by o.order_date)
        )
        /
        nullif(
            lag(o.revenue, 1) over (order by o.order_date),
            0
        ),
        4
    ) as revenue_vs_yesterday_pct,

    round(
        (
            o.revenue
            - lag(o.revenue, 7) over (order by o.order_date)
        )
        /
        nullif(
            lag(o.revenue, 7) over (order by o.order_date),
            0
        ),
        4
    ) as revenue_vs_last_weekday_pct

from daily_orders o

left join daily_refunds r
    on o.order_date = r.refund_date

order by o.order_date;
