const axios = require('axios');
let response;

/**
 *
 * Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format
 * @param {Object} event - API Gateway Lambda Proxy Input Format
 *
 * Context doc: https://docs.aws.amazon.com/lambda/latest/dg/nodejs-prog-model-context.html
 * @param {Object} context
 *
 * Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
 * @returns {Object} object - API Gateway Lambda Proxy Output Format
 *
 */
exports.lambdaHandler = async (event, context) => {
  try {
    const endPoint = process.env.ENDPOINT;
    const data = event

    const attachments = [{
      "color": "#FF9900",
      "pretext": "Session Manager Event",
      "title": data.detail.eventName,
      "fields": [
        {
            "title": "Time",
            "value": data.detail.eventTime,
            "short": true
        },
        {
            "title": "Session ID",
            "value": data.detail.responseElements.sessionId,
            "short": true
        },
        {
            "title": "User Name",
            "value": data.detail.userIdentity.userName,
            "short": true
        },
        {
            "title": "Source IP Address",
            "value": data.detail.sourceIPAddress,
            "short": true
        },
        {
            "title": "Region",
            "value": data.detail.awsRegion,
            "short": true
        },
        {
            "title": "Instance ID",
            "value": data.detail.requestParameters.target,
            "short": true
        },
        {
            "title": "UserAgent",
            "value": data.detail.userAgent,
            "short": false
        }
      ]
    }]

    response = await axios.post(endPoint, { "attachments": attachments })
    console.log(response);
  } catch (err) {
    console.log(err);
    return err;
  }

  return {
    status: response.stats,
    statusText: response.statusText
  }
};
