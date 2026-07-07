-- Query 03: Funnel Conversion by Acquisition Channel
-- Business Question:
-- Where in the funnel does each channel's traffic leak?

WITH session_data AS (

    SELECT

        se.session_id,

        COALESCE(sc.channel, 'direct') AS channel,

        se.event_type

    FROM ecom.session_events se

    LEFT JOIN ecom.session_channels sc
        ON se.session_id = sc.session_id

    -- Event tracking started on 19-Apr-2026
    WHERE se.occurred_at >= '2026-04-19'

),

funnel_counts AS (

    SELECT

        channel,

        COUNT(DISTINCT session_id) AS sessions,

        COUNT(DISTINCT session_id)
            FILTER (WHERE event_type = 'product_view')
            AS product_view_sessions,

        COUNT(DISTINCT session_id)
            FILTER (WHERE event_type = 'add_to_cart')
            AS add_to_cart_sessions,

        COUNT(DISTINCT session_id)
            FILTER (WHERE event_type = 'begin_checkout')
            AS begin_checkout_sessions,

        COUNT(DISTINCT session_id)
            FILTER (WHERE event_type = 'purchase')
            AS purchase_sessions

    FROM session_data

    GROUP BY channel

)

SELECT

    channel,

    sessions,

    product_view_sessions,

    add_to_cart_sessions,

    begin_checkout_sessions,

    purchase_sessions,

    ROUND(
        add_to_cart_sessions * 1.0
        / NULLIF(product_view_sessions, 0),
        4
    ) AS view_to_cart_rate,

    ROUND(
        begin_checkout_sessions * 1.0
        / NULLIF(add_to_cart_sessions, 0),
        4
    ) AS cart_to_checkout_rate,

    ROUND(
        purchase_sessions * 1.0
        / NULLIF(begin_checkout_sessions, 0),
        4
    ) AS checkout_to_purchase_rate,

    ROUND(
        purchase_sessions * 1.0
        / NULLIF(sessions, 0),
        4
    ) AS session_to_purchase_rate

FROM funnel_counts

ORDER BY sessions DESC;
