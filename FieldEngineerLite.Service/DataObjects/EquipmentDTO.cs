// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
// This file reused (with modifications) from: https://code.msdn.microsoft.com/Field-Engineer-501df99d

using Microsoft.WindowsAzure.Mobile.Service;

namespace FieldEngineerLite.Service.DataObjects
{
    public class EquipmentDTO
    {
        public string Description { get; set; }
        public string EquipmentNumber { get; set; }
        public string FullImage { get; set; }
        public string Name { get; set; }
        public string ThumbImage { get; set; }
    }
}
