terraform{
    backend "s3"{
        bucket = "terraform-jenkins-basic-cicd-rahil"
        key = "Jenkins-terraform-statefile/terraform.tfstate"
        region = "us-west-2"
        encrypt = true
        use_lockfile = true

    }
}