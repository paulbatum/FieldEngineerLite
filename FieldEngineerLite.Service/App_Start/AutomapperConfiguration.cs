// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
// This file reused from: https://code.msdn.microsoft.com/Field-Engineer-501df99d

using AutoMapper;
using FieldEngineerLite.Service.DataObjects;
using FieldEngineerLite.Service.Models;

namespace FieldEngineerLite.Service
{
    public class AutomapperConfiguration
    {
        public static void CreateMapping(IConfiguration cfg)
        {
            // Apply some name changes from the entity to the DTO
            cfg.CreateMap<Job, JobDTO>()                
                .ForMember(jobDTO => jobDTO.Equipments, map => map.MapFrom(job => job.Equipments));

            // For incoming requests, ignore the relationships
            cfg.CreateMap<JobDTO, Job>()                                            
                .ForMember(job => job.Customer, map => map.Ignore())
                .ForMember(job => job.Equipments, map => map.Ignore());

            cfg.CreateMap<Customer, CustomerDTO>();            
            cfg.CreateMap<Equipment, EquipmentDTO>();
        }
    }
}
