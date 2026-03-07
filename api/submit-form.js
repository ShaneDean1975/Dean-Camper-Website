const https = require('https');

module.exports = async function handler(req, res) {
    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Method not allowed' });
    }

    try {
        const { Field1, Field2, Field3, Field4, Field6, Field8, Field10 } = req.body || {};

        const formBody = new URLSearchParams({
            Field1:  Field1  || '',
            Field2:  Field2  || '',
            Field3:  Field3  || '',
            Field4:  Field4  || '',
            Field6:  Field6  || '',
            Field8:  Field8  || '',
            Field10: Field10 || ''
        }).toString();

        const credentials = Buffer.from('G80S-OD80-43CZ-51EB:footastic').toString('base64');

        const data = await new Promise((resolve, reject) => {
            const options = {
                hostname: 'deancamper.wufoo.com',
                path: '/api/v3/forms/r15j7yku0dbtffn/entries.json',
                method: 'POST',
                headers: {
                    'Authorization': 'Basic ' + credentials,
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Content-Length': Buffer.byteLength(formBody)
                }
            };

            const request = https.request(options, (response) => {
                let body = '';
                response.on('data', chunk => body += chunk);
                response.on('end', () => {
                    try { resolve(JSON.parse(body)); }
                    catch (e) { resolve({ raw: body }); }
                });
            });

            request.on('error', reject);
            request.write(formBody);
            request.end();
        });

        if (data.Success === 1) {
            return res.status(200).json({ success: true });
        } else {
            return res.status(400).json({ success: false, detail: data });
        }
    } catch (err) {
        return res.status(500).json({ success: false, error: err.message });
    }
};
