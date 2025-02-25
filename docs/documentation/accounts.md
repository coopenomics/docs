Аккаунт в MONO - это составной объект с информацией о пользователе. Он составляется из информации, которая описывает состояние пользователя на разных уровнях работы платформы с идентификацией по имени пользователя - username. 

Username — это уникальный идентификатор пользователя в системе. Он состоит из 12 латинских букв без пробелов и специальных символов. С помощью него производится сквозная идентификация принадлежности аккаунта к пользователю во всех кооперативных системах платформы. 

## Объект аккаунта
У каждого аккаунта есть 4 уровня хранения информации, их удобно проследить по объекту {{ get_graphql_definition("Account") }} в GraphQL-API: 


{{ get_graphql_definition("BlockchainAccount") }} -  объект аккаунта в блокчейне содержит системную информацию, такую как публичные ключи доступа, доступные вычислительные ресурсы, информация об установленном смарт-контракте, и т.д. и т.п. Это системный уровень обслуживания, где у каждого пайщика есть аккаунт, но не каждый аккаунт может быть пайщиком в каком-либо кооперативе. Все смарт-контракты устанавливаются и исполняются на этом уровне. 

{{ get_graphql_definition("UserAccount") }} -  объект пользователя кооперативной экономики содержит в блокчейне информацию о типе аккаунта пайщика, а также, обезличенные публичные данные (хэши) для верификации пайщиков между кооперативами. Этот уровень предназначен для хранения информации пайщика, которая необходима всем кооперативам, но не относится к какому-либо из них конкретно. 

{{ get_graphql_definition("ParticipantAccount") }} -  объект пайщика кооператива в таблице блокчейне, который определяет членство пайщика в конкретном кооперативе. Поскольку MONO обслуживает только один кооператив, то в participant_account обычно содержится информация, которая описывает членство пайщика в этом кооперативе. Этот объект обезличен, публичен, и хранится в блокчейне. 

{{ get_graphql_definition("ProviderAccount") }} -  объект аккаунта в системе учёта провайдера, т.е. MONO. Здесь хранится приватная информация о пайщике кооператива, которая содержит его приватные данные. Эти данные не публикуются в блокчейне и не выходят за пределы базы данных провайдера. Они используются для заполнения шаблонов документов при нажатии соответствующих кнопок на платформе. Также, эта информация используется провайдером для организации входа пользователя в систему по наличию соответстветсвия между email и username в его базе данных и блокчейне ([подробнее](/documentation/auth/#about-auth))

<a id="register-account"></a>
## Зарегистрировать аккаунт
{{ get_sdk_doc("Mutations", "Accounts", "RegisterAccount") }} | {{ get_graphql_doc("Mutation.registerAccount") }}

Вызов мутации регистрации аккаунта создаёт объект аккаунта в системе учета провайдера. После вызова, пользователь получает возможность входа в систему на основании предоставленного при регистрации публичного ключа и адреса электронной почты. 


!!! note ""
    Успешный вызов мутации НЕ означает, что пользователь становится пайщиком и получает блокчейн-аккаунт. При вызове мутации пользователь получает только объект {{ get_graphql_definition("ProviderAccount") }}, а для его перехода в пайщики необходимо пройти дополнительный путь, описанный в разделе [Регистрация Пайщика](/documentation/participants). 

{{ get_typedoc_desc("Mutations.Accounts.RegisterAccount") }}


Регистрация аккаунта производится мутацией RegisterAccount, где в качестве переменных принимаются данные пользователя одного из трех типов, определяемых в перечислении AccountType: Individual (физическое лицо), Organization (юридическое лицо) или Entrepreneur (индивидуальный предприниматель).

При указании типа пользователя Individual необходимо передать объект individual_data с данными физлица, при регистрации Organization - ожидается обязательная передача organization_data, при указании типа Entrepreneur - entrepreneur_data. 
 
Имя пользователя username и публичный ключ public_key генерируются вызовом метода generateAccount из SDK:

```typescript

import {generateAccount} from '@coopenomics/sdk'

const account = generateAccount()

```

В объекте account после генерации аккаунта содержится имя пользователя, приватный и публичный ключ. Сгенерированный приватный ключ из объекта аккаунта будет требоваться для входа в систему после регистрации. 
  
```typescript

// console.log(account)
{
  name: "abcd1234wxyz",
  privateKey: "5JxyzABC1234567890defGHIJKLMNopqRSTUV",
  publicKey: "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5SozEZ8i8jUBS6yX79y6"
}
  
```

Используя сгенерированный объект аккаунта с ключами, проводим регистрацию в системе учёта провайдера:

{{ get_typedoc_input("Mutations.Accounts.RegisterAccount") }}


По-умолчанию, каждый пайщик регистрирует новый аккаунт в том кооперативе, в который вступает. Кооператив, при этом, самостоятельно управляет процессом восстановления ключей доступа, в случае их утери. 

<a id="get-account"></a>
## Извлечь аккаунт
{{ get_sdk_doc("Queries", "Accounts", "GetAccount") }} | {{ get_graphql_doc("Query.getAccount") }}

Запрос извлечения объекта аккаунта по username. Может быть выполнен председателем или членом совета на любой аккаунт, или пользователем, с собственным username. Если запрос совершает пользователь, то он должен предоставить свой username, который совпадёт с тем именем аккаунта, которое будет извлечено из JWT на бэкенде. 

Аккаунты извлекаются по именам пользователей с помощью запроса GetAccount. В случае, если у username нет какого-либо уровня аккаунта из представленных выше, то он будет возвращен, тогда как все остальные, которые есть - будут. 

<!-- {{ get_typedoc_desc("Queries.Accounts.GetAccount") }} -->

{{ get_typedoc_input("Queries.Accounts.GetAccount") }}

<a id="get-accounts"></a>
## Извлечь лист аккаунтов
{{ get_sdk_doc("Queries", "Accounts", "GetAccounts") }} | {{ get_graphql_doc("Query.getAccounts") }}

{{ get_typedoc_desc("Queries.Accounts.GetAccounts") }}

{{ get_typedoc_input("Queries.Accounts.GetAccounts") }}

Результат будет представлен в виде объекта с массивом items, где каждый элемент массива - это составной объект аккаунта.

<a id="update-account"></a>
## Обновить аккаунт
{{ get_sdk_doc("Mutations", "Accounts", "UpdateAccount") }} | {{ get_graphql_doc("Mutation.updateAccount") }}

{{ get_typedoc_desc("Mutations.Accounts.UpdateAccount") }}

{{ get_typedoc_input("Mutations.Accounts.UpdateAccount") }}

Обновление персональных данных в базе MONO производится добавлением нового объекта с указанием последнего необратимого блока в блокчейне, что позволяет использовать исторические данные для сверки и восстановления документов. Вся история изменений данных аккаунтов сохраняется. 


<a id="reset-key"></a>
## Восстановить доступ к аккаунту
В случае утери ключи, доступ к аккаунту возможно восстановить только с помощью его замены в блокчейне. Для этого, необходимо последовательно применить две мутации: StartResetKey и ResetKey.

### Получить токен для замены
{{ get_sdk_doc("Mutations", "Accounts", "StartResetKey") }} | {{ get_graphql_doc("Mutation.startResetKey") }}

{{ get_typedoc_desc("Mutations.Accounts.UpdateAccount") }}


### Заменить ключ
{{ get_sdk_doc("Mutations", "Accounts", "ResetKey") }} | {{ get_graphql_doc("Mutation.resetKey") }}

{{ get_typedoc_desc("Mutations.Accounts.ResetKey") }}



<!-- ## Удалить аккаунт
{{ get_sdk_doc("Mutations", "Accounts", "RegisterAccount") }} | {{ get_graphql_doc("Mutation.registerAccount") }}

{{ get_typedoc_desc("Mutations.Accounts.DeleteAccount") }}
 -->





