export const api = {
    getExchangeID: {
        method: 'GET',
        path: '/external/member/details/#{var.NRIC}',
        params: {},
        headers: {
            Accept: "*/*",
            "Content-Type": "application/json",
            "User-Agent": "rt/1.0",
            "x-api-key":"123b549ddcf54cfa8cf2b190398fc8ce",
        },
        expectedStatus: 200
    }
}