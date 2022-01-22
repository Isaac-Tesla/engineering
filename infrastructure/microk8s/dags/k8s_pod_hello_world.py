from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.contrib.operators.kubernetes_pod_operator import KubernetesPodOperator
from datetime import timedelta
import os

with DAG(dag_id='hello_world_kube_pod_operator',
         default_args={'owner': 'airflow'},
         schedule_interval='@daily',
         start_date=days_ago(1)
    ) as dag:

    k8s_task = KubernetesPodOperator(
        task_id='kube_pod_operator_hello_world',  # Node name in Airflow
        image=f'hello-world:latest',
        is_delete_operator_pod=True,
        in_cluster=True,
        get_logs=True,
        namespace='airflow',
        name='hello-world',  # K8s pod name prefix
        dag=dag
    )

k8s_task