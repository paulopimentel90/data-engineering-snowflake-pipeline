{{ config(
    materialized='incremental',
    unique_key='transactionid'
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
    base.transactionid,

    customer.customer_key,
    merchant.merchant_key,
    device.device_key,
    location.location_key,
    channel.channel_key,

    to_number(to_char(base.transactiondate, 'YYYYMMDD')) as date_id,

    base.transactionamount,
    base.transactionduration,
    base.loginattempts,
    base.accountbalance

from base

join customer
    on base.accountid = customer.accountid

join merchant
    on base.merchantid = merchant.merchantid

join device
    on base.deviceid = device.deviceid

join location
    on base.location = location.location

join channel
    on base.channel = channel.channel