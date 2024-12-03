<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken("auth_token")->plainTextToken;

        return response()->json(
            [
                "user" => $user,
                "token" => $token,
                "message" => "Registration successful",
                "status" => "success",
            ],
            201
        );
    }

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
