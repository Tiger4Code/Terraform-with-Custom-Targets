#!/bin/bash

# Check if a valid command is passed (plan, apply, destroy)
if [[ "$1" != "plan" && "$1" != "apply" && "$1" != "destroy" ]]; then
  echo "Usage: $0 {plan|apply|destroy} [auto-approve]"
  exit 1
fi

# Check if the first argument is followed by the "y" flag for auto-approve
AUTO_APPROVE=""
if [[ "$2" == "y" ]]; then
  AUTO_APPROVE="-auto-approve"
fi

# Read target.txt to get the list of files to include
TARGET_FILE="target.txt"
if [[ ! -f "$TARGET_FILE" ]]; then
  echo "Error: $TARGET_FILE does not exist."
  exit 1
fi

# Create an array to hold the Terraform targets
TARGET_RESOURCES_AND_MODULES=()

# Read target.txt line by line and process each file
while IFS= read -r line; do
  if [[ -f "$line" ]]; then
    # Extract resource names (resource "type" "name") using grep with extended regex (-E)
    RESOURCES=$(grep -Eo 'resource\s+"[^"]+"\s+"[^"]+"' "$line" | awk '{print $2 "." $3}')
    
    # Extract module names (module "name") using grep with extended regex (-E)
    MODULES=$(grep -Eo 'module\s+"[^"]+"' "$line" | awk '{print "module." $2}')
    
    if [[ -n "$RESOURCES" || -n "$MODULES" ]]; then
      # Add the resource and module names to the array
      TARGET_RESOURCES_AND_MODULES+=($RESOURCES $MODULES)
      echo "Resources and modules found in $line:"
      echo "  Resources: $RESOURCES"
      echo "  Modules: $MODULES"
    else
      echo "No resources or modules found in $line."
    fi
  else
    echo "Warning: $line not found, skipping."
  fi
done < "$TARGET_FILE"

# Check if there are any resources or modules to target
if [[ ${#TARGET_RESOURCES_AND_MODULES[@]} -eq 0 ]]; then
  echo "Error: No valid resources or modules found in target.txt."
  exit 1
fi

# Print out the resources and modules to be targeted
echo "Targeting resources and modules: ${TARGET_RESOURCES_AND_MODULES[@]}"

# Run the appropriate Terraform command
case "$1" in
  "apply")
    echo "Running terraform apply for selected resources and modules..."
    COMMAND="terraform apply ${AUTO_APPROVE}"
    # Add targets to the command
    for target in "${TARGET_RESOURCES_AND_MODULES[@]}"; do
      COMMAND="$COMMAND -target=$target"
    done
    echo "Executing: $COMMAND"
    eval $COMMAND
    ;;
  "plan")
    echo "Running terraform plan for selected resources and modules..."
    COMMAND="terraform plan"
    # Add targets to the command
    for target in "${TARGET_RESOURCES_AND_MODULES[@]}"; do
      COMMAND="$COMMAND -target=$target"
    done
    echo "Executing: $COMMAND"
    eval $COMMAND
    ;;
  "destroy")
    echo "Running terraform destroy for selected resources and modules..."
    COMMAND="terraform destroy ${AUTO_APPROVE}"
    # Add targets to the command
    for target in "${TARGET_RESOURCES_AND_MODULES[@]}"; do
      COMMAND="$COMMAND -target=$target"
    done
    echo "Executing: $COMMAND"
    eval $COMMAND
    ;;
  *)
    echo "Invalid command."
    exit 1
    ;;
esac
