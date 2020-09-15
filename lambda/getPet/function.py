def handler(event, context):
    data["Event"] = event;
    data["Env"] = process.env.NODE_ENV;
    return data
