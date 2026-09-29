# <folder-name>

> <One sentence describing what this stack stands up, in plain language. Say what it is for, not how it works.>

**Region:** `<aws-region>` · **VPC:** `<creates a new VPC | reuses the account default VPC>` · **Provider:** `hashicorp/aws <version constraint>`

## What this provisions

<Two to four sentences of prose. Cover: the overall shape of the deployment, whether networking is created or
reused, how the compute is sized/counted, and what the stack is intended for. This is the paragraph a reader
should be able to stop after.>

### Resources created

| # | Resource | Terraform address | Key configuration |
|---|----------|-------------------|-------------------|
| 1 | <Human name, e.g. "Public subnet"> | `<aws_subnet.public>` | <CIDR, AZ, notable flags> |
| 2 | | | |

### Data sources (lookups only — nothing is created)

| Data source | Purpose |
|-------------|---------|
| `<data.aws_vpc.default>` | <What it resolves and why the stack needs it.> |

> Omit this section entirely if the stack creates everything it needs and looks nothing up.

## Architecture

```mermaid
flowchart TB
    <Replace with a diagram of THIS stack. See the notes at the bottom of this file for the conventions.>
```

## Inputs

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `<var_name>` | `string` | `<default or "(required)">` | <Description.> |

## Outputs

| Output | Description |
|--------|-------------|
| `<output_name>` | <What it returns and when you'd use it.> |

## Prerequisites

- <AWS credentials with permission to create the resources above.>
- <An existing EC2 key pair named in the variables — the private key must be on the machine you SSH from.>
- <Anything that must already exist before `apply` (a default VPC, an AMI, a hosted zone, …).>

## Deploy

```bash
terraform init
terraform plan
terraform apply
```

<If the folder ships a `terraform.tfvars.example`, note that it must be copied to `terraform.tfvars` first.
If the folder ships a real `terraform.tfvars`, note that it is gitignored and must be recreated by each user.>

## Notes and caveats

- <Anything a future reader would otherwise have to reverse-engineer: security trade-offs, resources that are
  adopted rather than created, commented-out code, things that look broken but are intentional.>

---

<!-- =====================================================================
TEMPLATE CONVENTIONS — delete this block in the finished README
=====================================================================

Sections are ordered for a reader who is skimming:
  title → what it is → what it makes → picture → knobs → how to run → gotchas

Prose vs table: the "What this provisions" paragraph is the summary; the
resource table is the exhaustive list. Never make the reader read the table
to understand the point of the stack.

Resource table: one row per Terraform resource block, in the order they
appear in main.tf. Use the real Terraform address in backticks so it can be
grepped. "Key configuration" should carry the values that actually matter
(CIDR, instance type, volume size, ingress ports) — not every argument.

Mermaid diagram conventions:
  - `flowchart TB` for containment/ownership, `flowchart LR` for a request or
    data path. Don't mix the two jobs in one diagram.
  - Put real infrastructure inside `subgraph` blocks for the boundary it
    belongs to (VPC, subnet, account). A resource that is reused rather than
    created should sit OUTSIDE the boundary it is borrowed from.
  - Label every edge with what flows along it (`SSH / HTTP / HTTPS`,
    `0.0.0.0/0 → IGW`) or use a dotted edge for "attached to".
  - Mirror the real identifiers (CIDRs, AZ, storage sizes, ports) from the
    code so the diagram can be fact-checked against main.tf.
  - Keep it to one diagram per README, ~15 nodes max. If the stack needs
    more than that, the README needs a second folder instead.

Inputs/outputs tables: copy the descriptions straight from variables.tf and
outputs.tf. Do not paraphrase them into something shorter — the descriptions
in code are the ones that stay in sync.

Notes and caveats: this is the highest-value section and the one most likely
to be skipped. It should include anything true about the code that is not
obvious from reading it, especially:
  - security group rules that are open to 0.0.0.0/0
  - resources adopted via `aws_default_*` rather than created
  - dead or commented-out code, and unused variables left behind
  - whether the stack reuses the account's default VPC (and therefore has
    no network isolation from anything else in the account)
===================================================================== -->
