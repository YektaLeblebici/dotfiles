#!/bin/sh

COMPONENTS=( bq gsutil core alpha beta cloud_sql_proxy config-connector )

gcloud components install "${COMPONENTS[@]}"
