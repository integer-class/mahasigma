<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Recommendation;
use App\Models\Mushroom;


class CheckSkinController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
         // Validasi input
        $request->validate([
            'files.*' => 'image|mimes:jpeg,png,jpg|max:5048', // Max size 5MB
        ]);

        $files = $request->file('files');


        $response = Http::attach(
            'file', file_get_contents($files), $files->getClientOriginalName()
        )->post('http://20.5.25.52/predict/'
        );

        $data = $response->json();

        $skin = Skin::where('name', $data)->first();
        $id = $mushroom->id;
        $mushroom = Recommendation::where('mushroom_id', $id)->first();


        return response()->json([
            'success' => true,
            'message' => 'Recommendations fetched successfully.',
            'mushroom' => $data,
            'data' => $mushroom,
        ], 200);







    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}