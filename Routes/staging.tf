provider "heroku" {}

resource "heroku_app" "default" {
  name   = "my-terraform-swagger-ui"
  region = "us"
  stack  = "container"
}

resource "heroku_build" "default" {
  app        = "${heroku_app.default.id}"

  source = {
    # A local directory, changing its contents will
    # force a new build during `terraform apply`
    path = "../Swagger-ui"
  }
}
