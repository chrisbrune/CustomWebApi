using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CustomWebApi.Controllers
{
    public class ProposalController : ApiController
    {
        public IHttpActionResult Get()
        {
            return Ok();
        }
    }
}
