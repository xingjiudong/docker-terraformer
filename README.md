# How to use

## Capabilities

1.  Generate `tf`/`json` + `tfstate` files from existing infrastructure for all
    supported objects by resource.
2.  Remote state can be uploaded to a GCS bucket.
3.  Connect between resources with `terraform_remote_state` (local and bucket).
4.  Save `tf`/`json` files using a custom folder tree pattern.
5.  Import by resource name and type.
6.  Support terraform 0.12 (for terraform 0.11 use v0.7.9).

Terraformer uses Terraform providers and is designed to easily support newly added resources.
To upgrade resources with new fields, all you need to do is upgrade the relevant Terraform providers.
```
Import current state to Terraform configuration from a provider

Usage:
   import [provider] [flags]
   import [provider] [command]

Available Commands:
  list        List supported resources for a provider

Flags:
  -b, --bucket string         gs://terraform-state
  -c, --connect                (default true)
  -С, --compact                (default false)
  -f, --filter strings        google_compute_firewall=id1:id2:id4
  -h, --help                  help for google
  -O, --output string         output format hcl or json (default "hcl")
  -o, --path-output string     (default "generated")
  -p, --path-pattern string   {output}/{provider}/ (default "{output}/{provider}/{service}/")
      --projects strings
  -z, --regions strings       europe-west1, (default [global])
  -r, --resources strings     firewall,networks or * for all services
  -s, --state string          local or bucket (default "local")
  -v, --verbose               verbose mode

Use " import [provider] [command] --help" for more information about a command.
```

### Use with AWS

Example:

```
 terraformer import aws --resources=vpc,subnet --connect=true --regions=eu-west-1 --profile=prod
 terraformer import aws --resources=vpc,subnet --filter=aws_vpc=vpc_id1:vpc_id2:vpc_id3 --regions=eu-west-1
```

#### Profiles support

AWS configuration including environmental variables, shared credentials file (\~/.aws/credentials), and shared config file (\~/.aws/config) will be loaded by the tool by default. To use a specific profile, you can use the following command:

```
terraformer import aws --resources=vpc,subnet --regions=eu-west-1 --profile=prod
```

You can also provide no regions when importing resources:
```
terraformer import aws --resources=cloudfront --profile=prod
```
In that case terraformer will not know with which region resources are associated with and will not assume any region. That scenario is useful in case of global resources (e.g. CloudFront distributions or Route 53 records) and when region is passed implicitly through environmental variables or metadata service.

* https://github.com/GoogleCloudPlatform/terraformer
