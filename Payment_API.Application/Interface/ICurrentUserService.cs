﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Interface
{
    public interface ICurrentUserService
    {
        public string? UserId { get; }
        public string? IpAddress { get; }
    }
}
