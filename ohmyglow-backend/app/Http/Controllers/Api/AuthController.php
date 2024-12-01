<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (!Auth::attempt($request->only("email", "password"))) {
            return response()->json(
                [
                    "user" => null,
                    "message" => "Invalid login details",
                    "status" => "failed",
                ],
                401
            );
        }

        $user = User::where("email", $request->email)->firstOrFail();
        $token = $user->createToken("auth_token")->plainTextToken;

        return response()->json(
            [
                "email" => $user->email,
                "token" => $token,
                "message" => "Login successful",
                "status" => "success",
            ],
            200
        );
    }

    public function logout(Request $request)
    {
        // Revoke the token that was used to authenticate the current request
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Successfully logged out',
            'status' => 'success',
        ], 200);
    }
}
