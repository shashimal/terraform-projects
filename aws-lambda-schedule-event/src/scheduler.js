async function handler(event) {
    console.log("New Job Stared")
    console.log(event)
    console.log("Job Finished")

    return {
        body: JSON.stringify({message: 'SUCCESS'}),
        statusCode: 200,
    };
}

module.exports = {handler};