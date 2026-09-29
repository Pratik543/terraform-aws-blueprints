# terraform-infrastructures

A reference collection of self-contained Terraform stacks. Each subfolder is an independent root module that can be
read, copied, and applied on its own — they are not composed together and share no state.

The purpose of this repository is **reference, not deployment**: each folder should be scannable in under a minute to
recall what it provisions and how it is wired.

## Stacks

| Folder | What it provisions | Network | Compute | Provider |
|---|---|---|---|---|
| [custom-vpc-public-host](./custom-vpc-public-host/) | A complete VPC from scratch plus one internet-facing host with a static Elastic IP | **Creates** a VPC `10.0.0.0/16`, IGW, one public subnet, default route table + default SG rewritten | 1 × Ubuntu 24.04 EC2, 20 GB gp3, Elastic IP | `aws ~> 6.53` |
| [ansible-control-node-and-workers](./ansible-control-node-and-workers/) | Hosts for an Ansible lab — one control node and a `count`-driven fleet of managed workers (no Ansible installed) | Reuses the account **default** VPC, default subnets, default SG | 1 × control node (20 GB gp3) + N × workers (15 GB gp3) | `aws ~> 6.53` |
| [default-vpc-ubuntu-instance](./default-vpc-ubuntu-instance/) | The minimal example — a single Ubuntu host, used as a starting point for other stacks | Reuses the account **default** VPC, default subnets, default SG | 1 × Ubuntu EC2, 20 GB gp3 | `aws ~> 6.53` |

## Choosing a starting point

- **Need networking built for you** → `custom-vpc-public-host` is the only stack that creates a VPC. Copy it when you
  want an isolated network rather than the account default.
- **Need multiple hosts to configure** → `ansible-control-node-and-workers` shows how this collection does a
  `count`-driven fleet, numbered tags, and an inventory-shaped output.
- **Need one host, quickly** → `default-vpc-ubuntu-instance` is the smallest thing here and the easiest to read.

## Two patterns worth noticing

**Only one stack builds a network.** `custom-vpc-public-host` creates its own VPC and has real isolation. The other
two reuse the account's default VPC, which means they have no network boundary between themselves or anything else in
the account. That is a deliberate simplification in the smaller stacks, not an oversight — but it is the single most
important difference between them.

**Security groups.** `custom-vpc-public-host` explicitly opens SSH, HTTP, and HTTPS to `0.0.0.0/0`. The two
default-VPC stacks attach the account's **default** security group, which by AWS default allows no inbound traffic
from the internet — so the SSH commands those stacks print in their outputs will not connect until an inbound rule is
added by hand. Reaching for the printed SSH command and finding it hangs is expected, not a bug.

## Conventions

- **Each folder is its own root module.** There is no shared module, no `terraform_remote_state`, and no dependency
  between folders. `cd` into one and work there.
- **`provider.tf` is identical in all three folders.** Each stack requires Terraform `>= 1.6.0`, pins
  `hashicorp/aws ~> 6.53`, and hard-codes `region = "ap-south-1"`. The region is not parameterised anywhere, so
  moving a stack to another region means editing `provider.tf` — and `availability_zone`, subnet CIDRs, and any
  AMI IDs would have to move with it, since those are all region-specific.
- **One region variable is now dead.** `custom-vpc-public-host` still declares `aws_region` and sets it in its tfvars,
  but its `provider.tf` hard-codes the region, so the variable is read by nothing.
- **No remote backend anywhere.** State is local `terraform.tfstate`, and gitignored. Nothing here is safe to
  collaborate on yet — if a stack graduates to real use, add a backend first.
- **`terraform.tfvars` is gitignored, and every folder ships a `terraform.tfvars.example`.** Copy it into place before
  planning. Because the real tfvars file is never committed, the example doubles as the only committed record of which
  variables a stack needs — including the ones with no usable default.
- **AMIs are handled differently per stack.** `custom-vpc-public-host` looks up the latest Canonical Ubuntu AMI at
  plan time; the other two take AMI IDs as variables.

## Repository layout

```
terraform-infrastructures/
├── custom-vpc-public-host/           # VPC + IGW + public subnet + EIP + one host
├── ansible-control-node-and-workers/ # Ansible control node + worker fleet
├── default-vpc-ubuntu-instance/      # single Ubuntu host
└── README.template.md                # skeleton used to write the per-folder READMEs
```

Every stack folder has the same contents: `README.md`, `main.tf`, `variables.tf`, `outputs.tf`, `provider.tf`, and a
`terraform.tfvars.example`. `custom-vpc-public-host` additionally looks up its AMI at plan time; the other two take
AMI IDs as variables.

Each folder's README follows the same shape: a one-line summary, a prose description of what is provisioned, a
resource table with Terraform addresses, a Mermaid architecture diagram, inputs and outputs, prerequisites, deploy
steps, and a notes section covering the non-obvious parts of the code.
