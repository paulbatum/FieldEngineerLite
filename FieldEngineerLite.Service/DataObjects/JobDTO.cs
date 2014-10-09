// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
// This file reused (with modifications) from: https://code.msdn.microsoft.com/Field-Engineer-501df99d

using System.Collections.Generic;
using Microsoft.WindowsAzure.Mobile.Service;

namespace FieldEngineerLite.Service.DataObjects
{
    public class JobDTO : EntityData
    {        
        public string AgentId { get; set; }
        public string EtaTime { get; set; }
        public string JobNumber { get; set; }
        public string Status { get; set; }
        public string Title { get; set; }
        
        public virtual CustomerDTO Customer { get; set; }
        
        public virtual List<EquipmentDTO> Equipments { get; set; }
    }
}
