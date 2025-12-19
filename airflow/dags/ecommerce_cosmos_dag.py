from airflow import DAG
from datetime import datetime
from cosmos import DbtTaskGroup
from cosmos.config import ProfileConfig, ProjectConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

profile = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_dev",
        profile_args={"database": "DEMO_ELT", "schema": "STAGE"}
    ),
)

project = ProjectConfig(
    project_name="ecommerce_dbt",
    dbt_project_path="/usr/local/airflow/dbt/ecommerce_dbt",
)

# ---------------------------------------
# DAG STARTS HERE
# ---------------------------------------
with DAG(
    dag_id="cosmos_ecommerce_dbt",
    start_date=datetime(2025, 12, 1),
    schedule="@daily",
    catchup=False,
):

    staging = DbtTaskGroup(
        group_id="staging_models",
        project_config=project,
        profile_config=profile,
        operator_args={"select": ["stg_*"]},
    )

    intermediate = DbtTaskGroup(
        group_id="intermediate_models",
        project_config=project,
        profile_config=profile,
        operator_args={"select": ["int_*", "inc_*"]},
    )

    marts = DbtTaskGroup(
        group_id="mart_models",
        project_config=project,
        profile_config=profile,
        operator_args={"select": ["dim_*","fact_*"]},
    )


    snapshots = DbtTaskGroup(
    group_id="snapshots",
    project_config=project,
    profile_config=profile,
    # operator_class="snapshot",
    operator_args={"select": ["customer_snapshot"]},
)

    # Set dependencies
    staging >> intermediate >> marts >> snapshots