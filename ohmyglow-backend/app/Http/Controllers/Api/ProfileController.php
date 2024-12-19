<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Profile;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class ProfileController extends Controller
{
    /**
     * Display the user's profile form.
     */
    public function index(Request $request)
    {
        // Ensure the user is authenticated
        
    }

    public function show($id)
    {
        $disease = Profile::where('user_id', $id)->get();

        if (!$disease) {
            return response()->json([
                'status' => 'error',
                'message' => 'Disease not found',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => $disease,
        ]);
    }


    public function edit(Request $request)
    {
        return response()->json($request->user());
    }

    /**
     * Update the user's profile information.
     */
    public function update(Request $request)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'fullname' => 'nullable|string|max:255',
            'nickname' => 'nullable|string|max:255',
            'age' => 'nullable|integer|min:1|max:120',
            //'email' => 'nullable|string|email|max:255|unique:users,email,' . $request->user()->id,
            //'password' => 'nullable|string|min:8|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        $user = $request->user();

        // Mengubah avatar jika ada
        if ($request->hasFile('avatar')) {
            $path = $request->file('avatar')->store('avatars', 'public');
            $user->avatar = $path;
        }

        // Mengubah password jika ada
        /*if ($request->filled('current_password') && $request->filled('new_password')) {
        if (!Hash::check($request->input('current_password'), $user->password)) {
            return response()->json(['error' => 'Current password is incorrect'], 422);
        }

        $user->update([
            'password' => Hash::make($request->input('new_password')),
        ]);
    }*/

        // Mengupdate data lainnya
        $user->fullname = $request->input('fullname', $user->fullname);
        $user->nickname = $request->input('nickname', $user->nickname);
        $user->age = $request->input('age', $user->age);
        //$user->email = $request->input('email', $user->email);

        // Simpan perubahan pada user
        $user->save();

        return response()->json(['message' => 'Profile updated successfully', 'user' => $user]);
    }

    /**
     * Delete the user's account.
     */
    public function destroy(Request $request)
    {
        $user = $request->user();
        $user->delete();

        return response()->json(['message' => 'Account deleted successfully']);
    }
}
