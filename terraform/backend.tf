terraform {
    backend "s3" {
        bucket = "terraformtfstatesstoragemanoj-807882256639-ap-south-1-an"
        key = "terraform/state.tfstate"
        region = "ap-south-1"
    }
}