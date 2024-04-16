terraform {
  cloud {
    hostname = "tfe25.aws.munnep.com"
    organization = "test"

    workspaces {
      name = "test"
    }
  }
}

resource "null_resource" "name" {
}