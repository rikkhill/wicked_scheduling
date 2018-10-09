// Because Terraform hasn't figured out Python exists...
exports.yo = (request, response) => {
    response.status(200).send("Yo!")
};