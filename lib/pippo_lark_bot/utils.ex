defmodule PippoLarkBot.Utils do
  @app_id Application.get_env(:pippo, :lark_bot)[:app_id]
  @app_secret Application.get_env(:pippo, :lark_bot)[:app_secret]

  @request_headers %{
    "Content-Type" => "application/json",
  }

  defp get_tenant_token do
    fetch_tenant_token()
  end

  @api_tenant_access_token "https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal/"
  defp fetch_tenant_token do
    %HTTPoison.Response{status_code: 200, body: response} = HTTPoison.post!(@api_tenant_access_token,
      Poison.encode!(%{
        "app_id" => @app_id,
        "app_secret" => @app_secret
      }), @request_headers)
    %{"code" => 0, "tenant_access_token" => token, "expire" => expire} = Poison.decode!(response)
    # TODO: DB
    token
  end

  def post_api_data(url, data) do
    %HTTPoison.Response{status_code: 200, body: response} = HTTPoison.post!(url,
      Poison.encode!(data |> Enum.reject(fn({_, v}) -> v == nil end) |> Enum.into(%{})),
      Map.merge(@request_headers, %{"Authorization" => "Bearer #{get_tenant_token()}"}))
    %{"code" => 0} = Poison.decode!(response)
    # TODO: code != 0
  end
end
