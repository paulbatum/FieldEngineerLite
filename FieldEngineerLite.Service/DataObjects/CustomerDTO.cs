// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
// This file reused (with modifications) from: https://code.msdn.microsoft.com/Field-Engineer-501df99d

using Microsoft.WindowsAzure.Mobile.Service;

namespace FieldEngineerLite.Service.DataObjects
{
    public class CustomerDTO
    {
        public string AdditionalContactNumber { get; set; }
        public string County { get; set; }
        public string FullName { get; set; }
        public string HouseNumberOrName { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string Postcode { get; set; }
        public string PrimaryContactNumber { get; set; }
        public string Street { get; set; }
        public string Town { get; set; }
    }
}
