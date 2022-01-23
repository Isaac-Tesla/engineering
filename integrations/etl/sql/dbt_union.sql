with source_t1 as (
    select * from {{ source('schema', 'table1') }}

),

source_t2 as (
    select * from {{ source('schema', 'table2') }}

),


union_ as (
    select
        *,
        '{{ var("schema_source_t1") }}' as source_account
    from source_t1

    union

    select
        *,
        '{{ var("schema_source_t2") }}' as source_account
    from source_t2
),


renamed as (
    select
        TO_NUMBER(id)                                           as other_id,
        TO_BOOLEAN(visible)                                     as visible,
        TO_NUMBER(position)                                     as position,
        TO_VARCHAR({{ text_cleaned('text') }})                  as text,
        TO_BOOLEAN(apply_all_rows)                              as apply_all_rows,
        TO_NUMBER(num_lines)                                    as num_lines,
        TO_VARCHAR(error_text)                                  as error_text,
        TO_BOOLEAN(is_answer_choice)                            as is_answer_choice,
        TO_NUMBER(num_chars)                                    as num_chars,
        TO_NUMBER(question_id)                                  as question_id,
        TO_VARCHAR(account)                                     as account
    from source_union
)


select * from renamed