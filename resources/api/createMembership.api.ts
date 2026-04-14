export const api = {
    createNewMembership1: {
        method: 'POST',
        path: '/external/ucem/membership',
        params: {},
        headers: {
            Accept: "*/*",
            "Content-Type": "application/json",
            "User-Agent": "rt/1.0",
            "x-api-key": "123b549ddcf54cfa8cf2b190398fc8ce"
        },
        body: {
            "FullName": "#{var.NRIC.Name_1}",
            "UIN": "#{var.NRIC_1}",
            "DateofBirth": "12/10/#{var.NRIC_1.Year}",
            "EmploymentType": "4",
            "Occupation": "IT",
            "OccupationGroupCode": "E01",
            "CompanyName": "SKYLINE AUTOMATION",
            "CompanyCode": "001356",
            "NatureofBusiness": "TEST AUTOMATION",
            "Race": "100000001",
            "SalaryGroup": "100000003",
            "Gender": "1",
            "MaritalStatus": "100000001",
            "EducationalLevel": "100000008",
            "Mobile": "81191503",
            "Email": "#{var.NRIC}@ntuc.sg",
            "PostalCode": "018907",
            "BlockAddress": "1",
            "Floor": "01",
            "UnitNo": "01",
            "StreetName": "STRAITS BOULEVARD",
            "BuildingName": "SINGAPORE CHINESE CULTURAL CENTRE",
            "ResidentalStatus": "100000002",
            "NationalityCode": "SG",
            "ApplicationMode": 8,
            "NametobePrintedCard": "#{var.PersonFullName}",
            "CreateCard": false,
            "InstantCard": false,
            "CreateunionMembership": true,
            "UnionCode": "NTUCGB",
            "BranchCode": "GB",
            "JoinUnionDate": "#{var.FirstDayCurrentMonth}",
            "CampaignCode": "",
            "FairPriceSubscription": true,
            "SubscriptionAccount": "",
            "SubscriptionBankCode": "",
            "SubscriptionBranchCode": "",
            "SubscriptionNRIC": "",
            "SubscriptionNTUCName": "",
            "ReferredBy": "",
            "RecruiterCode": "",
            "CreatePayment": true,
            "NumberofMonths": 1,
            "PaidAmount": "9",
            "PaymentStatus": 2,
            "ReferenceNumber": "OMA2026031242176514CC",
            "PeriodFrom": "#{var.FirstDayCurrentMonth}",
            "PeriodTo": "#{var.LastDayCurrentMonth}",
            "TransactionDateTime": "01/03/2026 14:24:21.000",
            "PaymentTypeCode": 19,
            "PaymentTypeName": "ONLINE + TOKEN",
            "CreatePaymentInstruction": true,
            "InstuctionPaymentTypeCode": "100000007",
            "BankCode": "7171",
            "BankBranchCode": "100",
            "rDDAReferenceNumber": "xxxxxxxx",
            "AccountNumber": "1003432301",
            "AccountHolderName": "#{var.NRIC.Name_1}",
            "ApplyDate": "#{var.FirstDayCurrentMonth} 14:18:02.000"
        },
        //expectedStatus: 200
    },

     getMemberDetails: {
        method: 'GET',
        path: '/external/ucem/membership',
        params: {},
        headers: {
            Accept: "*/*",
            "Content-Type": "application/json",
            "User-Agent": "rt/1.0",
            "x-api-key": "123b549ddcf54cfa8cf2b190398fc8ce"
        },
        body:{

        }
    }

}

   
