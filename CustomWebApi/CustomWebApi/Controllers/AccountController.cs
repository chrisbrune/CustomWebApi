using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Models.Models;
using BusinessLayer;
using BusinessLayer.Interfaces;
using System.Threading.Tasks;

namespace CustomWebApi.Controllers
{
    public class AccountController : ApiController
    {
        IUserBusiness userBusiness;

        public AccountController()
        {
            userBusiness = new UserBusiness();
        }

        [HttpPost]
        public async Task<IHttpActionResult> Add(UserModel user)
        {

            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await userBusiness.Add(user);

            if (result)
                return Ok();

            return BadRequest();
        }


        [HttpGet]
        [Route("api/Account/Get")]
        public async Task<IHttpActionResult> Get(Guid Id)
        {
            if (Id == null)
            {
                return BadRequest();
            }

            var model = await userBusiness.Get(Id);

            if (model == null)
                return BadRequest("Invalid Login");

            return Ok(model);


        }

            [HttpPost]
            [Route("api/Account/Login")]
            public async Task<IHttpActionResult> Login(UserLoginModel user)
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest();
                }

            if (await userBusiness.Validate(user))
            {
               
                return Ok();
            }

                return BadRequest("Invalid Login");
            }


    }
}
