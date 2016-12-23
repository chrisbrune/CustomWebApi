using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.Models;
using Repository.Interfaces;
using System.Data;
using Dapper;

namespace Repository.Repositories
{
    public class UserRepository : IUserRepository
    {

        public UserRepository()
        {

        }

        public async Task<bool> Add(UserModel user)
        {
            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(@"Data Source=DESKTOP-2PQP7CF\SQL;Initial Catalog=TechProposalDB;Integrated Security=SSPI;User ID = sa; Password = Oracle1!;"))
            {
                const string storedProcedure = "dbo.uspAddUser";
                var p = new DynamicParameters();
                p.Add("@pFirstName", user.FirstName);
                p.Add("@pLastName", user.LastName);
                p.Add("@pEmail", user.Email);
                p.Add("@pPassword", user.Password);

                p.Add("responseMessage", dbType: DbType.Boolean, direction: ParameterDirection.Output);
                await connection.ExecuteAsync(storedProcedure, p ,commandType: CommandType.StoredProcedure);
                return p.Get<bool>("responseMessage");  
            }
            
        }

        public async Task<bool> Validate(UserLoginModel user)
        {
            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(@"Data Source=DESKTOP-2PQP7CF\SQL;Initial Catalog=TechProposalDB;Integrated Security=SSPI;User ID = sa; Password = Oracle1!;"))
            {
                const string storedProcedure = "dbo.uspLogin";
                var p = new DynamicParameters();
                p.Add("@pEmail", user.Email);
                p.Add("@pPassword", user.Password);

                p.Add("responseMessage", dbType: DbType.Boolean, direction: ParameterDirection.Output);
                await connection.ExecuteAsync(storedProcedure, p, commandType: CommandType.StoredProcedure);
                return p.Get<bool>("responseMessage");
            }
        }

        public async Task<bool> Exists(string email)
        {
            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(@"Data Source=DESKTOP-2PQP7CF\SQL;Initial Catalog=TechProposalDB;Integrated Security=SSPI;User ID = sa; Password = Oracle1!;"))
            {
                const string storedProcedure = "dbo.userExists";
                var p = new DynamicParameters();
                p.Add("@pEmail", email);

                p.Add("responseMessage", dbType: DbType.Boolean, direction: ParameterDirection.Output);
                await connection.ExecuteAsync(storedProcedure, p, commandType: CommandType.StoredProcedure);
                return p.Get<bool>("responseMessage");
            }
        }

        public async Task<UserModel> Get(Guid Id)
        {
            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(@"Data Source=DESKTOP-2PQP7CF\SQL;Initial Catalog=TechProposalDB;Integrated Security=SSPI;User ID = sa; Password = Oracle1!;"))
            {
                
                return await connection.QueryFirstAsync<UserModel>("SELECT Id, FirstName, LastName, Email FROM [dbo].[User] WHERE Id = @Id", new { Id });
               
            }
        }





    }
}
