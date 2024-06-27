#!/bin/bash

# Define an array of models (use dbt ls --resource-type=model)
models=(
    "model_name_1"
    "model_name_2"
)
#!/bin/bash

# Check if GNU Parallel is installed
if ! command -v parallel &> /dev/null; then
    echo "GNU Parallel is not installed. Please install it to use this script."
    exit 1
fi

# Add headers to the CSV file
echo "model,upstream_src_count,upstream_model_count,downstream_model_count,test_count" > output.csv

# Function to process a single model
process_model() {
    local model=$1
    local upstream_src_count=$(dbt ls --resource-type=source -s +$model | tail -n +4 | wc -l)
    local upstream_model_count=$(dbt ls --resource-type=model -s +$model | tail -n +4 | wc -l)
    local downstream_model_count=$(dbt ls --resource-type=model -s $model+ | tail -n +4 | wc -l)
    local test_count=$(dbt ls --resource-type=test -s $model | tail -n +4 | wc -l)

    upstream_model_count=$((upstream_model_count - 1))
    downstream_model_count=$((downstream_model_count - 1))

    echo "$model,$upstream_src_count,$upstream_model_count,$downstream_model_count,$test_count"
}

export -f process_model

total_models=${#models[@]}
start_time=$(date +%s)

# Run the process_model function in parallel for all models
parallel --bar --eta --jobs 4 process_model ::: "${models[@]}" >> output.csv

end_time=$(date +%s)
total_time=$((end_time - start_time))
echo "Total execution time: $total_time seconds"
