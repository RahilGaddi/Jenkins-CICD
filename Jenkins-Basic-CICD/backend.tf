terraform{
    backend "s3"{
        bucket = "terraform-jenkins-basic-cicd"
        key = "Jenkins-terraform-statefile/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true

    }
}