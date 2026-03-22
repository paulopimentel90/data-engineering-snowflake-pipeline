{{ config(
    materialized='incremental',
    unique_key='transaction_id'
) }}

with base as (

    select *
    from {{ ref('int_transactions') }}

    {% if is_incremental() %}
        where created_at > (select max(created_at) from {{ this }})
    {% endif %}

),

customer as (

    select *
    from {{ ref('dim_customer') }}

),

merchant as (

    select *
    from {{ ref('dim_merchant') }}

),

device as (

    select *
    from {{ ref('dim_device') }}

),

location as (

    select *
    from {{ ref('dim_location') }}

),

channel as (

    select *
    from {{ ref('dim_channel') }}

)

select
    base.transaction_id,

    customer.customer_key,
    merchant.merchant_key,
    device.device_key,
    location.location_key,
    channel.channel_key,

    to_number(to_char(base.transaction_date, 'YYYYMMDD')) as date_id,

    base.transaction_amount,
    base.transaction_duration,
    base.login_attempts,
    base.account_balance

from base

join customer
    on base.account_id = customer.account_id

join merchant
    on base.merchant_id = merchant.merchant_id

join device
    on base.device_id = device.device_id

join location
    on base.location = location.city

join channel
    on base.channel = channel.channel