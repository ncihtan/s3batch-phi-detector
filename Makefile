
# SCRIPT (Method 1)
# aws_detect_pii.py functionality
deid: ohsu hms washu vanderbilt

# For targeting or ignore a specific prefix to identify use
# add --prefix <target_prefix>
# or add --ignore-prefix <h_and_e>
ohsu:
	python scripts/aws_detect_pii.py \
		-b htan-dcc-ohsu \
		--bucket-type aws \
		--profile sandbox-developer \
		--prefix imaging_level_2 \
		--comprehend_profile htan-dev \
		> outputs/ohsu_output.tsv

hms:
	python scripts/aws_detect_pii.py \
		-b htan-dcc-hms \
		--bucket-type aws \
		--comprehend_profile htan-dev \
		--profile sandbox-developer \
		--prefix imaging_level_2 \ 
		--comprehend_profile htan-dev \
		> outputs/hms_output.tsv

washu:
	python scripts/aws_detect_pii.py \
		-b htan-dcc-washu \
		--bucket-type gcs \
		--profile htan-dcc-gcs \
		--prefix h_and_e \
		--comprehend_profile htan-dev \
		> outputs/washu_he_output.tsv
	python scripts/aws_detect_pii.py \
		-b htan-dcc-washu \
		--bucket-type gcs \
		--profile htan-dcc-gcs \
		--prefix imaging_level_2 \ 
		--comprehend_profile htan-dev \
		> outputs/washu_imc_output.tsv

vanderbilt:
	python scripts/aws_detect_pii.py \
		-b htan-dcc-vanderbilt \
		--bucket-type aws \
		--profile sandbox-developer \
		--comprehend_profile htan-dev \
		> outputs/vanderbilt_output.tsv



# LAMBDA & S3Batch prior work with deidentification functionality
# (Method 2), for posterity
deploy:
	sam deploy --profile htan-dev-admin --guided
process_s3batch:
	python scripts/process_s3batch_jobs.py batch_jobs.json
