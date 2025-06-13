# IaC Tool Alias Switching System

This system allows you to switch between different sets of aliases for infrastructure as code (IaC) tools:

- Terraform
- Terragrunt
- Pulumi
- Kubernetes

## Usage

To switch between different IaC tool aliases, use the `use` command:

```bash
# Switch to Terraform aliases
use terraform

# Switch to Terragrunt aliases
use terragrunt

# Switch to Pulumi aliases
use pulumi

# Switch to Kubernetes aliases
use kubernetes

# Disable all IaC tool-specific aliases
use none
```

## Available Commands

After switching to a specific tool, you'll have access to that tool's specific command aliases. For example:

- `init` - Initializes the current directory (varies by tool)  
- `refresh` - Refreshes state (varies by tool)
- `plan` - Plans changes (Terraform/Terragrunt)
- `preview` - Preview changes (Pulumi)
- `apply` - Applies changes (Terraform/Terragrunt)
- `up` - Deploys changes (Pulumi)
- `k` - Shorthand for `kubectl` (Kubernetes)
- `kg` - Get resources (Kubernetes)
- `kd` - Describe resources (Kubernetes)
- `kl` - Logs (Kubernetes)
- `ke` - Exec into pods (Kubernetes)
- etc.

## Base Commands

Regardless of which alias set is active, the following base commands are always available:

- `t` - Shorthand for `terraform`
- `tg` - Shorthand for `terragrunt`
- `pl` - Shorthand for `pulumi`
- `k` - Shorthand for `kubectl`

## Default Tool

By default, the system loads Terraform aliases on startup. To change this behavior, modify the `.aliases` file.

## How It Works

The system works by:

1. Storing each tool's aliases in separate files (`.aliases-terraform`, `.aliases-terragrunt`, `.aliases-pulumi`, `.aliases-kubernetes`)
2. Providing a `use` function that:
   - Unaliases any potentially conflicting commands
   - Sources the appropriate alias file based on your selection
   - Sets an environment variable to track the current tool

## Customization

To add more aliases for any tool, edit the corresponding `.aliases-*` file. 