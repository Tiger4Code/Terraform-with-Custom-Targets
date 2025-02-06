# Terraform Targeted Apply/Plan/Destroy Script

This script allows you to run `terraform plan`, `terraform apply`, and `terraform destroy` on selected Terraform files listed in a `target.txt` file. It helps automate the process of working with multiple Terraform configuration files, allowing you to target only a subset of files specified in `target.txt`, and apply or destroy them with ease.

## Purpose

This script is designed to:
- Run `terraform plan` or `terraform apply` only for the Terraform files listed in `target.txt`.
- Perform `terraform destroy` on the targeted files, with an optional confirmation step.
- Provide an easy way to automate the `plan`, `apply`, and `destroy` commands on a selective set of Terraform files.

## Prerequisites

Before running the script, ensure that:
- You have [Terraform](https://www.terraform.io/downloads) installed.
- The `target.txt` file exists in your Terraform directory and contains the list of files to include for Terraform operations (e.g., `s3.tf`, `ebs.tf`).
- The script `tftarget.sh` should be located in the `terraform/` folder, next to `target.txt`.
- The script has been made executable.

## How to Use the Script

### 1. Make the script executable

To make the `tftarget.sh` script executable, run the following command:
```bash
   chmod +x tftarget.sh
```

### 2. Create a `target.txt` file

Create a file named `target.txt` in the `terraform/` folder. This file should contain the names of the Terraform files you want to run commands for, each on a new line, and file should end with an extra line. For example:
```
s3.tf 
ebs.tf 
ecr.tf

```

This allows you to specify only the Terraform files you want to work with (for example, `s3.tf`, `ebs.tf`, and `ecr.tf`) while excluding others like `vpc.tf` or `aks.tf` from the operation.


### 3. Run the script

You can now run the script with the following commands:

#### Run `terraform plan` for the files in `target.txt`:
```bash
./tftarget.sh plan
```

#### Run terraform apply for the files in target.txt:
```
./tftarget.sh apply
```

#### Run terraform apply and automatically approve the apply:
```
./tftarget.sh apply y
```

#### Run terraform destroy for the files in target.txt:
```
./tftarget.sh destroy
```

#### Run terraform destroy and automatically approve the destruction:
```
./tftarget.sh destroy y
```

### 4. Workflow Explanation
- plan: This command will show you a preview of the changes to be made to the resources specified in the files listed in target.txt. If "y" is passed, the plan will be automatically approved for the next step.
- apply: This command applies the changes defined in the files listed in target.txt. If "y" is passed, the apply will be automatically approved.
- destroy: This command will destroy the resources defined in the files listed in target.txt. If "y" is passed, the destruction will be automatically approved.

For both plan and destroy, if "y" is not provided, you will be prompted for confirmation before applying or destroying the changes.


### Troubleshooting

- target.txt is missing: The script expects a target.txt file to exist in the terraform/ directory. Ensure that this file exists and contains the correct filenames of your Terraform files.
- Invalid command: If you pass an invalid command (not plan, apply, or destroy), the script will display a usage message and exit. Ensure you use one of the valid commands.


## Author

This script was created by Noor Sabahi, a Principal AI Engineer (Tiger4Code). Feel free to reach out if you have any questions or suggestions.